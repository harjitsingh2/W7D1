class User < ApplicationRecord

    before_validation :ensure_session_token

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    validates :username, :session_token, :password_digest, presence: true
    validates :username, uniqueness: true
    validates :password, allow_nil: true
    # validates :password, length { minimum 6}

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


end

