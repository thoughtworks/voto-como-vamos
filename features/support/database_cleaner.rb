require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
Before { DatabaseCleaner.clean }
