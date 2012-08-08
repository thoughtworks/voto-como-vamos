# -*- encoding : utf-8 -*-

class WhitespaceCheck < Struct.new(:pattern, :message)

  def lines
    @lines ||= []
  end

  def check(line, number)
    lines << number if line =~ pattern
  end

  def self.check_file filename
    whitespace_checks = [
      WhitespaceCheck.new(/\s+\n$/, "has EOL spaces"),
      WhitespaceCheck.new(/\r/, "has DOS EOL characters"),
      WhitespaceCheck.new(/\t/, "has tab characters")
    ]

    File.readlines(filename).each_with_index do |line, number|
      whitespace_checks.each {|w| w.check(line, number+1)}
    end

    whitespace_checks.map {|m| m.error_for(filename)}.compact.uniq
  end

  def self.delete_whitespaces_for(files)
    files_with_trailing_whitespaces = []
    @whitespace_errors ||= files.inject([]) do |errors, filename|
      puts "Checking #{filename}…" if ENV['VERBOSE']
      error_list = check_file filename

      unless error_list.empty?
        files_with_trailing_whitespaces << filename
        system "sed 's\/[ \t\r]*$\/\/' #{filename} > temp"
        system "rm #{filename}"
        system "mv temp #{filename}"
        puts "Cleaned #{filename}"
      end
    end
    files_with_trailing_whitespaces
  end

  def error_for(file)
    "#{file} #{message} on lines #{lines.join(',')}" unless lines.empty?
  end

  def self.whitespace_errors_for(files)
    @whitespace_errors ||= files.sort.uniq.inject([]) do |errors, filename|
      puts "Checking #{filename}…" if ENV['VERBOSE']
      errors += check_file filename
    end
  end
end

def files
  include_files = [
    /\.rb$/,
    /\.pp$/,
    /\.erb$/,
    /\.haml$/,
    /\.js$/,
    /\.yml$/,
    /\.yaml$/,
    /\.slim$/,
    /\.css$/,
    /\.sass$/,
    /\.scss$/,
    /\.gemspec$/,
    /\.rake$/,
    /\.coffee$/,
    /\.less$/,
    /Gemfile$/,
    /Capfile$/,
    /Rakefile$/,
  ]

  exclude_files = [
    %r[^vendor/],
    %r[^coverage/],
    %r[^tmp/],
    %r[^spec/cassettes/],
    %r[^.bundle],
    %r[^.gitstats],
  ]

  files = `git ls-files -c -m -o`.split("\n").select do |f|
    include_files.any? {|filter| f =~ filter && File.exists?(f) } &&
    exclude_files.none? {|filter| f =~ filter }
  end
  files
end

desc 'Alias for check for whitespace problems'
task :whitespace => 'whitespace:check'

namespace :whitespace do
  desc "Checks for whitespace problems"
  task :check do
    errors = WhitespaceCheck.whitespace_errors_for files
    if errors.any?
      puts errors.join("\n")
      raise "This project has whitespace errors. Please fix them before proceeding."
     end
  end

  desc 'whitepasce:clean - needs sed'
  task :clean do
    sanitized_files = WhitespaceCheck.delete_whitespaces_for files
    puts "Deleted trailing whitespaces for #{sanitized_files.join(',')}." unless sanitized_files.empty?
  end
end
