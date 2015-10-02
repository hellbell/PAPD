%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name : PART ASSOCIATION
% Date : 2015.09.22
% Author : HaanJu.Yoo
% Version : 0.9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                            ....
%                                           W$$$$$u
%                                           $$$$F**+           .oW$$$eu
%                                           ..ueeeWeeo..      e$$$$$$$$$
%                                       .eW$$$$$$$$$$$$$$$b- d$$$$$$$$$$W
%                           ,,,,,,,uee$$$$$$$$$$$$$$$$$$$$$ H$$$$$$$$$$$~
%                        :eoC$$$$$$$$$$$C""?$$$$$$$$$$$$$$$ T$$$$$$$$$$"
%                         $$$*$$$$$$$$$$$$$e "$$$$$$$$$$$$$$i$$$$$$$$F"
%                         ?f"!?$$$$$$$$$$$$$$ud$$$$$$$$$$$$$$$$$$$$*Co
%                         $   o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%                 !!!!m.*eeeW$$$$$$$$$$$f?$$$$$$$$$$$$$$$$$$$$$$$$$$$$$U
%                 !!!!!! !$$$$$$$$$$$$$$  T$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%                  *!!*.o$$$$$$$$$$$$$$$e,d$$$$$$$$$$$$$$$$$$$$$$$$$$$$$:
%                 "eee$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$C
%                b ?$$$$$$$$$$$$$$**$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$!
%                Tb "$$$$$$$$$$$$$$*uL"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
%                 $$o."?$$$$$$$$F" u$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%                  $$$$en ```    .e$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
%                   $$$B*  =*"?.e$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$F
%                    $$$W"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
%                     "$$$o#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
%                    R: ?$$$W$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$" :!i.
%                     !!n.?$???""``.......,``````"""""""""""``   ...+!!!
%                      !* ,+::!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*`
%                      "!?!!!!!!!!!!!!!!!!!!~ !!!!!!!!!!!!!!!!!!!~`
%                      +!!!!!!!!!!!!!!!!!!!! !!!!!!!!!!!!!!!!!!?!`
%                    .!!!!!!!!!!!!!!!!!!!!!' !!!!!!!!!!!!!!!, !!!!
%                   :!!!!!!!!!!!!!!!!!!!!!!' !!!!!!!!!!!!!!!!! `!!:
%                .+!!!!!!!!!!!!!!!!!!!!!~~!! !!!!!!!!!!!!!!!!!! !!!.
%               :!!!!!!!!!!!!!!!!!!!!!!!!!.`:!!!!!!!!!!!!!!!!!:: `!!+
%               "~!!!!!!!!!!!!!!!!!!!!!!!!!!.~!!!!!!!!!!!!!!!!!!!!.`!!:
%                   ~~!!!!!!!!!!!!!!!!!!!!!!! ;!!!!~` ..eeeeeeo.`+!.!!!!.
%                 :..    `+~!!!!!!!!!!!!!!!!! :!;`.e$$$$$$$$$$$$$u .
%                 $$$$$$beeeu..  `````~+~~~~~" ` !$$$$$$$$$$$$$$$$ $b
%                 $$$$$$$$$$$$$$$$$$$$$UU$U$$$$$ ~$$$$$$$$$$$$$$$$ $$o
%                !$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$. $$$$$$$$$$$$$$$~ $$$u
%                !$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$! $$$$$$$$$$$$$$$ 8$$$$.
%                !$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$X $$$$$$$$$$$$$$`u$$$$$W
%                !$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$! $$$$$$$$$$$$$".$$$$$$$:
%                 $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$  $$$$$$$$$$$$F.$$$$$$$$$
%                 ?$$$$$$$$$$$$$$$$$$$$$$$$$$$$f $$$$$$$$$$$$' $$$$$$$$$$.
%                  $$$$$$$$$$$$$$$$$$$$$$$$$$$$ $$$$$$$$$$$$$  $$$$$$$$$$!
%                  "$$$$$$$$$$$$$$$$$$$$$$$$$$$ ?$$$$$$$$$$$$  $$$$$$$$$$!
%                   "$$$$$$$$$$$$$$$$$$$$$$$$Fib ?$$$$$$$$$$$b ?$$$$$$$$$
%                     "$$$$$$$$$$$$$$$$$$$$"o$$$b."$$$$$$$$$$$  $$$$$$$$'
%                    e. ?$$$$$$$$$$$$$$$$$ d$$$$$$o."?$$$$$$$$H $$$$$$$'
%                   $$$W.`?$$$$$$$$$$$$$$$ $$$$$$$$$e. "??$$$f .$$$$$$'
%                  d$$$$$$o "?$$$$$$$$$$$$ $$$$$$$$$$$$$eeeeee$$$$$$$"
%                  $$$$$$$$$bu "?$$$$$$$$$ 3$$$$$$$$$$$$$$$$$$$$*$$"
%                 d$$$$$$$$$$$$$e. "?$$$$$:`$$$$$$$$$$$$$$$$$$$$8
%         e$$e.   $$$$$$$$$$$$$$$$$$+  "??f "$$$$$$$$$$$$$$$$$$$$c
%        $$$$$$$o $$$$$$$$$$$$$$$F"          `$$$$$$$$$$$$$$$$$$$$b.
%       M$$$$$$$$U$$$$$$$$$$$$$F"              ?$$$$$$$$$$$$$$$$$$$$$u
%       ?$$$$$$$$$$$$$$$$$$$$F                   "?$$$$$$$$$$$$$$$$$$$$u
%        "$$$$$$$$$$$$$$$$$$"                       ?$$$$$$$$$$$$$$$$$$$$o
%          "?$$$$$$$$$$$$$F                            "?$$$$$$$$$$$$$$$$$$
%             "??$$$$$$$F                                 ""?3$$$$$$$$$$$$F
%                                                       .e$$$$$$$$$$$$$$$$'
%                                                      u$$$$$$$$$$$$$$$$$
%                                                     `$$$$$$$$$$$$$$$$"
%                                                      "$$$$$$$$$$$$F"
%                                                        ""?????""
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAMETER AND PRESET, INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbstop if error
addpath library;

image = imread('data/frame_0062.jpg');
imageScale = 2.0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART RESPONSE AND PRE-PROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load data/part_candidates.mat;
load model/INRIAPERSON_star.mat; % Load DPM model
numComponent = length(unique(coords(end-1,:)));
[numPartTypes, numDetections] = size(partscores);
numPartTypes = numPartTypes - 1; % since the last row of partscores is "pyramidLevel"

%==========================================
% NON-MAXIMAL SUPPRESSION WITH EACH PART
%==========================================
numParts = 0;
cellIndexAmongType = cell(numPartTypes, numComponent); % array positions of a specific part and component
for componentIdx = 1:numComponent
    
    % get data of current component
    curComponentIdx = find(componentIdx == coords(end-1,:));
    curComponents = coords(:,curComponentIdx);
    curComponentScores = partscores(:,curComponentIdx);   
    
    typeOffset = 1;
    for typeIdx = 1:numPartTypes
        
        % non-maximal suppression
        curCoords = curComponents(typeOffset:typeOffset+3,:);
        curScores = curComponentScores(typeIdx,:);
        pickedIdx = nms2([curCoords; curScores]', 0.3);
        
        % save candidates part into 'CPart' class instances
        curArrayIndex = [];
        for candidateIdx = pickedIdx'
            curScore = curComponentScores(typeIdx,candidateIdx);
            curCoord = curCoords(:,candidateIdx)';
            curPyraLevel =  curComponentScores(end, candidateIdx);
            curScale = 2 / ( 2 ^ ( 1 / model.interval ) )^(curPyraLevel-1);            
            numParts = numParts + 1;
            listCParts(numParts) = CPart(componentIdx, typeIdx, curCoord, curScore, curPyraLevel, curScale);
            curArrayIndex = [curArrayIndex, numParts];
        end
        
        % save specific part positions locations in the array of class
        cellIndexAmongType{typeIdx,componentIdx} = curArrayIndex;
        
        typeOffset = typeOffset + 4;
    end
end


%------------------------
% test codes
%------------------------
% imshow(image);
% for i = 1 : length(cellIndexAmongType{4,1})
%     P1 = listCParts(cellIndexAmongType{4,1}(i));
%     Box1 = GetBox(P1) / imageScale;
%     cellIndexAmongType{4,1}(i)
%     rectangle('Position', Box1, 'EdgeColor', 'r');
%     pause;
% end
% P1 = listCParts(28);
% CDC = CDistinguishableColors();
% P1_neighbor = [28, P1.type];
% for i = 1 : length(listCParts)
%     P2 = listCParts(i);
%     if (P1.type == 1 || P2.type == 1)
%         continue;
%     end
%     if (CheckCompatibility(P1, P2, model) == true ...
%             && CheckCompatibility(P2, P1, model) == true)  
%         P1_neighbor = [P1_neighbor; i, P2.type];
%         Box1 = GetBox(P1) / imageScale;
%         Box2 = GetBox(P2) / imageScale;
%         rectangle('Position', Box1, 'EdgeColor', GetColor(CDC, P1.type));
%         rectangle('Position', Box2, 'EdgeColor', GetColor(CDC, P2.type));
%         fprintf('i = %d, type = %d\n',i, P2.type);
%     end
% %     fprintf('%d\n',i);
% end
% matCompatibility = zeros(9,9);
% for i = 1 : size(P1_neighbor,1)
%     for j = 1: size(P1_neighbor,1)
%         PN1 = listCParts(P1_neighbor(i,1));
%         PN2 = listCParts(P1_neighbor(j,1));
%         if (CheckCompatibility(PN1, PN2, model) == true ...
%             && CheckCompatibility(PN2, PN1, model) == true)  
%             matCompatibility(PN1.type,PN2.type) = 1;
%         end
%     end
% end
% matCompatibility
% pause;
% ------------------------
% test codes END
% ------------------------



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GRAPH CONSTRUCT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CPG = CPartGraph(listCParts, cellIndexAmongType, model);
load 'combinations.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% OPTIMIZATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solve MWCP with the graph

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REFINEMENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VISUALIZATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CDC = CDistinguishableColors();

for typeIdx = 1:numPartTypes
    figure(typeIdx);
    imshow(image, 'border', 'tight');
    hold on;
    for partIdx = 1:numParts
        if typeIdx ~= listCParts(partIdx).type, continue; end

        curBox = GetBox(listCParts(partIdx)) / imageScale;
        rectangle('Position', curBox, 'EdgeColor', GetColor(CDC, listCParts(partIdx).type));
    end
    hold off;
end

numPartsInCombination = zeros(size(combinations, 1), 1);
for combIdx = 1:size(combinations,1)
    curCombination = combinations(combIdx,:);
    numPartsInCombination(combIdx) = numel(curCombination(curCombination ~= 0));
end

fullPartCombination = combinations(8 == numPartsInCombination,:);
% draw all parts of the combination results 
figure(100);
imshow(image, 'border', 'tight');
hold on;
BBs = [];
for combIdx = 1:size(fullPartCombination,1)
    curCombination = fullPartCombination(combIdx,:);
    curPartBoxes = [];
    for typeIdx = 2:9
        curBox = GetBox(listCParts(curCombination(typeIdx))) / imageScale;
        rectangle('Position', curBox, 'EdgeColor', GetColor(CDC, typeIdx));
        curPartBoxes = [curPartBoxes; curBox];
    end
    % Save bounding boxes of full body
    %   should be modified when consider partial body.
    BB = []; % [x y w h]
    BB(1) = min(curPartBoxes(:,1));
    BB(2) = min(curPartBoxes(:,2));
    BB(3) = max(curPartBoxes(:,1) + curPartBoxes(:,3)) - BB(1);
    BB(4) = max(curPartBoxes(:,2) + curPartBoxes(:,4)) - BB(2);
    BBs = [BBs; BB]; 
end
hold off;
% draw bounding boxes of the combination results
figure(101);
imshow(image, 'border', 'tight');
hold on;
for combIdx = 1:size(fullPartCombination,1)
    rectangle('Position', BBs(combIdx,:), 'EdgeColor', GetColor(CDC, 10));
end
hold off;

%()()
%('') HAANJU.YOO