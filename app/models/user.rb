class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :option, dependent: :destroy
  has_many :events, dependent: :destroy

  after_create :create_options

  private

  def create_options
  	@option = self.build_option
  	@option.save
  end
end
