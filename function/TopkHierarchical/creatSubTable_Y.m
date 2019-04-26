%% creatSubTable_Y
% Written by Xinxin Liu
% 2018-11-08
%% Creat subtable
function LabelMod=creatSubTable_Y(Y, tree)
Label =  Y;
[numY,~] = size(Label);
internalNodes = tree_InternalNodes(tree);
indexRoot = tree_Root(tree);% The root of the tree
noLeafNode =[internalNodes;indexRoot];
for i = 1:length(noLeafNode)
    cur_descendants = tree_Descendant(tree, noLeafNode(i));
    ind_d = 1;  % index for id subscript increment
    id = [];        % data whose labels belong to the descendants of the current nodes
    for n = 1:numY
        if (ismember(Label(n), cur_descendants) ~= 0)
            id(ind_d) =  n;
            ind_d = ind_d +1;
        end
    end
    Label_Uni_Sel = Label(id,:);   
    numTrainSel = size(Label_Uni_Sel,1);
    LabelUniSelMod = label_modify_MLNP(Label_Uni_Sel, noLeafNode(i), tree);%% 
    % Get the sub-training set containing only relative nodes
    ind_tdm = 1;
    index = [];     % data whose labels belong to the children of the current nodes
    children_set = get_children_set(tree, noLeafNode(i));
    for ns = 1:numTrainSel
        if (ismember(LabelUniSelMod(ns), children_set) ~= 0)
            index(ind_tdm) =  ns;
            ind_tdm = ind_tdm +1;
        end
    end
    LabelMod{noLeafNode(i)} = LabelUniSelMod(index, :);
end
end