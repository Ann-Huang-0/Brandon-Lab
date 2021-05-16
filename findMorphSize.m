function morph_size = findMorphSize(path)
    % hard-coded environmental structures in current morphing paradigm
    env_list   = ["Sq1","Sq2","Sq3","G3","G2","G1"];
    morph_size = {[0 0],[3 2],[4 3],[5 4],[6,5],[7,6]};
    % find which environment it is given the path
    env = cat(1, regexp(path, 'G[123]', 'match'), regexp(path, 'Sq[123]', 'match'));
    morph_size = morph_size{strcmp(env_list, env(1))};
end
