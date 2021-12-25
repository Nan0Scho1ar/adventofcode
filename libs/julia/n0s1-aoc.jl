
function readstring(fname)
    chomp(open(fname) do file
        read(file, String)
    end)
end
