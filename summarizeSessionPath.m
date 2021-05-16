function sessionPath = summarizeSessionPath(folderPath)
    folder = dir(folderPath);
    sessionPath = {};
    for i = 1 : length(folder)
        if contains(folder(i).name, '.mat')
            sessionPath{end+1} = folder(i).name;
        end
    end
end
        
    

