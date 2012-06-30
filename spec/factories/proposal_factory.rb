# encoding: utf-8

FactoryGirl.define do
  factory :proposal do
    title       'Título'
    abstract    'Resumo'
    description 'Descrição'
    candidate
  end

  factory :invalid_proposal, :class => Proposal do
    title       ''
    abstract    ''
    description ''
  end
end
