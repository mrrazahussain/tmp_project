ActiveAdmin.register Course do
  permit_params :title, :summary, :image, :category_id, author_ids: []

  index do
    selectable_column
    id_column
    column :image do |c|
      link_to image_tag(c.image.url(:thumb)), resource_path(c)
    end
    column :title
    column :category
    actions
  end

  filter :title

  form do |f|
    f.inputs "Course Details" do
      f.input :title
      f.input :image, as: :file
      f.input :category, collection: options_for_categories_dropdown
      f.input :authors, as: :select2_multiple
      f.input :summary
    end
    f.actions
  end

  show do
    panel "Course Enrollments" do
      render partial: "enrollments", locals: {course: resource}
    end
    active_admin_comments
  end

  sidebar "Details", only: :show do
    attributes_table_for course do
      row :title
      row :image do
        image_tag course.image.url(:thumb)
      end
      row :authors do
        course.authors.pluck('email').join('<br/>').html_safe
      end
      row :summary
      row :created_at
      row :updated_at
    end
  end

  member_action :enroll, method: :post do
    Enrollment.create(course_id: resource.id, user_id: params[:enrollment][:user])
    redirect_to resource_path(resource), notice: 'Enrollment updated'
  end

  member_action :un_enroll, method: :get do
    subscription = Enrollment.where(course_id: resource.id, user_id: params[:user_id])
    subscription.destroy_all
    redirect_to resource_path(resource), notice: 'Enrollment updated'
  end
end