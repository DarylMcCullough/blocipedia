module WikisHelper
    def user_is_authorized_for_wikis?
        return current_user.present?
   end
   
   def user_is_authorized_for_wiki?(wiki)
        return current_user.present?
   end
end
