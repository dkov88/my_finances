class Ability
  include CanCan::Ability

  def initialize(user)

    can :create, Wallet
    can [:update, :destroy], Wallet do |wallet|
      wallet.try(:email) == user.email
    end
  end
end
