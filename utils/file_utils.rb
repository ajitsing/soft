class FileUtil
  def self.read(filename)
    data = ""
    File.open(filename) do |file|
      file.each { |line| data += line}
    end

    data
  end
end
