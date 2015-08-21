namespace :mail do
  desc 'Send admin report'
  task send_admin_report: :environment do

    AdminReportMailer.admin_report.deliver
  end
end
