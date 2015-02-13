set :output, '../../shared/log/scheduler.log'
every 1.day, at: '1:00 am' do
  rake "apartments:load"
end
