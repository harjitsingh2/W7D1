class User < ApplicationRecord

    before_validation :ensure_session_token

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    validates :username, :session_token, :password_digest, presence: true
    validates :username, uniqueness: true
    # validates :password, length: { minimum: 6 }, allow_nil: true

    attr_reader :password

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    # substitute method name is_password?
    def check_password(password)
        password_object = BCrypt::Password.new(self.password_digest)

        password_object.is_password?(password)
    end 

    # Find user by username
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.check_password(password)
            user 
        else 
            nil 
        end 
    end 

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    private 
    # create a method to dry up our code
    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end

end

