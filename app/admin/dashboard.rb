ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Activities" do
          table_for PaperTrail::Version.order('id desc').limit(20) do # Use PaperTrail::Version if this throws an error
            # column ("Item") { |v| v.item }
            column ("Event") { |v| v.event.humanize }
            column ("Type") { |v| v.item_type.underscore.humanize }
            column ("Item") { |v| link_to v.item.paper_trail_title, '#' } # [:admin, v.item] }
            column ("Modified at") { |v| v.created_at.to_s :long }
            #column ("Admin") { |v| link_to User.find(v.whodunnit).full_name, [:admin, User.find(v.whodunnit)] }
          end
        end
      end
    end
  end
end
