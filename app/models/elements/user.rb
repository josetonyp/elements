module Elements
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :contents, foreign_key: 'creator_id', class_name: Elements::User
    has_many :galleries, foreign_key: 'creator_id', class_name: Elements::User
    has_many :pages, foreign_key: 'creator_id', class_name: Elements::User

    has_many :chips, foreign_key: 'creator_id', class_name: Elements::User
    has_many :menus, foreign_key: 'creator_id', class_name: Elements::User

    has_many :attachments, foreign_key: 'creator_id', class_name: Elements::User
    has_many :pictures, foreign_key: 'creator_id', class_name: Elements::User

  end
end
