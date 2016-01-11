require "pp"

dirs = %w(/ /archive1/ /archive2/ /archive3/ /archive4/ /archive5/ /archive6/ /archive7/ /archive8/ /archive9/ /archivex/)
files = []
dirs.each do |dir|
  s = `./dropbox_uploader.sh list #{dir}`
  #  [F] BAKA_2014_0603_0100.mp3
  files += s.split("\n").map{|s| s[/\[F\] (.+.mp3)/,1] }.compact.map{|s| [dir,s,s[/(\d\d\d\d_\d\d\d\d_\d\d\d\d)\.mp3/,1]] }
end
files = files.sort_by{|d,f,t| t||'0000' }.reverse

files_per_dir = 20
dirs.each_with_index do |dir,i|
  puts "DIR #{dir}"
  n = files_per_dir
  n = files.size if i==dirs.size-1
  _files = files[i*files_per_dir,n] || []
  _files.each do |d,f,t|
    if d!=dir
      puts "  move %10s -> %10s %s" % [d,dir,f]
      puts `./dropbox_uploader.sh move #{d}#{f} #{dir}#{f}`
    else
      puts "       %10s -> %10s %s" % [d,dir,f]
    end
  end
end
