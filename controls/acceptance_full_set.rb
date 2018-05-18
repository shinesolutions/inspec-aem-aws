control 'full-set-cloudwatch-alarms-exists' do
  impact 1.0
  title 'Check if full-set cloudwatch alarms exist'
  desc 'full-set cloudwatch alarms should be available'
  describe acceptance do
    alarms = File.readlines('conf/cw_alarms-full-set.txt')
    alarms.each do |alarm|
      it { should have_all_full_set_cloudwatch_alarms(alarm.chomp) }
    end
  end
end
