# def open_terminal(init_dir: String)
#   system "osascript -e 'tell application \"Terminal\" to do script \"cd #{init_dir} \" '"
# end

def spell_diff_check(file1: String, file2: String)
  stdin, stdout, stderr = Open3.popen3("diff -c #{file1} #{file2}")
  stdout.each do |diff|
    p diff.chomp
  end
end

def time_check(start_time: Time)
  end_time = Time.now
  elapsed_time = end_time - start_time - 1
  return elapsed_time
end

def run_rspec
  workshop_dir = "#{ENV['HOME']}/ruby_learner/workshop"
  how_complete =  system "cd #{workshop_dir} && rspec spec/workplace_spec.rb"
  return how_complete
end

def typing_discriminant(answer_path: String, question_path: String)
  loop do
    if run_rspec == true then
      puts "It have been finished!"
      break
    else
      puts "your code did an unexpected move!, please fix."
      # spell_diff_check(file1: "#{answer_path}", file2: "#{question_path}")
      instruct_print
      select = STDIN.gets.chomp
      workshop_dir = "#{ENV['HOME']}/ruby_learner/workshop/lib"
      if select == 'exit'
        break
      elsif select == 'answer'
        system "cd #{workshop_dir} && emacs -nw -q -l ~/ruby_learner/workshop/emacs.d/ruby_learner_init.el answer.rb"
      else
        system "cd #{workshop_dir} && emacs -nw -q -l ~/ruby_learner/workshop/emacs.d/init.el  sentence.org workplace.rb"
      end
    end
  end
end

# def cp_file(origin_file: String, clone_file: String)
#   FileUtils.cp("#{origin_file}",  "#{clone_file}")
# end

def instruct_print
  puts "If you continue this mode, press return-key"
  puts "When you want to finish this mode, input 'exit' and press return-key"
  puts "if you check the answer example, input 'answer' and press return_key"
end

def init_mk_files(origin_dir: String, prac_dir: String)
  if Dir.exist?(prac_dir) != true then
    FileUtils.mkdir_p(prac_dir)
    system("cp -R #{origin_dir}/workshop/* #{prac_dir}")
  end
end

def get_app_ver(app_name: String)
  app_vers = Open3.capture3("gem list #{app_name}")
  latest_ver = app_vers[0].chomp.gsub(' (', '-').gsub(')','')
  return latest_ver
end

def mk_training_data(elapsed_time: Time, prac_dir: String)
  training_file = "#{prac_dir}/training_data.txt"
  if File.exist?(training_file) != true then
    FileUtils.touch(training_file)
  end
  File.open(training_file, "a") do |file|
    file.puts("#{Time.now} #{elapsed_time.truncate(2)} sec")
  end
end
