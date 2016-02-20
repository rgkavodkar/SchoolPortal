module CoursesHelper

	def active_instructor?(user)
		if Course.count(user_id:user.id) == 0
			false
		else
			true
		end
	end
end
