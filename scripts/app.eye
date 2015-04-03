Eye.application 'dog_play_date' do
  puts File.expand_path(File.join(File.dirname(__FILE__), '..'))
  working_dir File.expand_path(File.join(File.dirname(__FILE__), '..'))
  stdall 'logs/trash.log' # stdout,err logs for processes by default
  env 'APP_ENV' => 'production' # global env for each processes

  process :thin do
    pid_file 'thin.pid'
    start_command 'bundle exec thin start -p 80 -d -l thin.log -P thin.pid'
    stop_signals [:QUIT, 2.seconds, :TERM, 1.seconds, :KILL]

    check :http, url: 'http://127.0.0.1/', pattern: /Puppy/,
                 every: 5.seconds, times: [2, 3], timeout: 1.second
  end
end
