class PostPolicy<ApplicationPolicy
    def index?
        true
    end

    def show?
        author? || record.public? || dungeonMaster?
    end

    def create?
        true
    end

    def update?
        author? || dungeonMaster?
    end

    def destroy?
        author? || dungeonMaster?
    end

    def non_published?
        user_logged_in?
    end

    private     
    def author?
        user_logged_in? && record.author_id == user.id
    end
 
end