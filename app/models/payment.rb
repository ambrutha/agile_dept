class Payment < ActiveRecord::Base
		::TYPE=
{
:visa=>"VISA",
:mastercard=>"MASTER CARD",
:americanexpress=>"AMERICAN EXPRESS"
}
belongs_to :user
end
