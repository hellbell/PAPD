function [stEvaluationResult] = Evaluate(stDetectionResult, cellGroundTruth)

% structure for evaluation (example)
stEvaluationResult = struct(...
    'precision', 0, ...
    'recall', 0, ...
    'missRate', 0, ...
    'FPPI', 0);

end