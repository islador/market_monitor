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
#  wallet_0     :string(255)
#  wallet_1     :string(255)
#  wallet_2     :string(255)
#  wallet_3     :string(255)
#  wallet_4     :string(255)
#  wallet_5     :string(255)
#  wallet_6     :string(255)
#

require 'spec_helper'

describe Corporation do
  pending "add some examples to (or delete) #{__FILE__}"
end
