% Simplified Adaptive Critic (SAC): Iterative Self-Training of Critic
% ===================================================================

clear all; clc; format short;

% Global variables
% ================

global Qw Rw dt

% Constants Used
% ==============

consts;                 % A Separate file

% Initialization of the Network
% =============================

initialize;             % A Separate file

% Pre-training
% ============

disp('Pre-Training Starts');

pre_training;           % A Separate file

disp('Pre-Training is Over');

save T_sim_pre;         % Saving the results of Pre-Training

                        % It is a good idea to check the pre-training
                        % networks from time domain simulations. 
                        % (see T_sim.m file)

% Actual Training
% ===============

disp('Actual Training Starts');

actual_training;		% A Separate file

disp('Training is Over');

save T_sim_inf net_C    % Saving the results of Training

% Saving the Entire Results
% =========================

save RESULT_inf


% Time Domain Simulations
% =======================

T_sim;                  % A Separate file
