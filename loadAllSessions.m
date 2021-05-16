function allSessions = loadAllSessions(folderPath, sessionPath)
    allSessions = {};
    for i = 1 : length(sessionPath)
        path = strcat(folderPath, '/', sessionPath{i});
        allSessions{end+1} = load(path);
    end
end
        
    
    