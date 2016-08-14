puts "https://github.com/Ogromny/BrainFuck2C"

puts "\nBrainfuck file: "
input_file  = gets.to_s.chomp

output      = String.new
output_file = input_file + ".c"

output << "#include <stdio.h>\n"
output << "\nint\nmain () {\n"
output << "\tchar a [0xFFFF] = { 0 };\n"
output << "\tchar * p = a;\n"

begin
    file = File.open input_file, "r+"

    tabs = 0

    loop do
        c = file.getc

        break if c == nil || c == "\n"

        str = "\t" * tabs

        output << case c.to_s
        when '>'
            str + "\t++ p;\n"
        when '<'
            str + "\t-- p;\n"
        when '+'
            str + "\t++ * p;\n"
        when '-'
            str + "\t-- * p;\n"
        when '.'
            str + "\tputchar (* p);\n"
        when ','
            str + "\t* p = getchar ();\n"
        when '['
            tabs += 1
            str + "\twhile (* p) {\n"
        when ']'
            tabs -= 1
            str + "}\n"
        end
    end

    output << "\treturn 0;\n}"
rescue IOError => e
    puts "Error: #{e}"
ensure
    file.close unless file.nil?
end

begin
    ofile = File.new output_file, "w"
    ofile.write output
rescue IOError => e
    puts "Error: #{e}"
ensure
    ofile.close unless file.nil?
end
