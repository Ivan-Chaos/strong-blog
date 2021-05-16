class CommentPolicy<ApplicationPolicy
    def create?
        true
    end

    def destroy?
        author?
    end

    private 
    def author?
        record.author_id==user.id
    end
end