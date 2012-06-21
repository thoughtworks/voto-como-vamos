# encoding: utf-8

require 'spec_helper'

describe Proposal do

  it { should belong_to(:candidate) }
  it { should validate_presence_of(:candidate) }

  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(100) }

  it { should validate_presence_of(:resumo) }
  it { should ensure_length_of(:resumo).is_at_most(300) }

  it { should validate_presence_of(:descricao) }

end
