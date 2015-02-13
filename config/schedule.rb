set :output, '../../shared/log/scheduler.log'
every 1.day, at: '1:00 am' do
  runner 'ApartmentsLoader.load_apartments'
end
