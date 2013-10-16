# == Schema Information
#
# Table name: corporations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  corp_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :integer
#

require 'spec_helper'

describe Corporation do
  pending "add some examples to (or delete) #{__FILE__}"
end
