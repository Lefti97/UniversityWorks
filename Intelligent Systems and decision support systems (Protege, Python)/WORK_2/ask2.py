import sys
from pm4py import read_xes
from pm4py import convert_to_dataframe
from pm4py.objects.conversion.log import converter as stream_converter
from pm4py.algo.discovery.heuristics import algorithm as heuristics_miner
from pm4py.visualization.heuristics_net import visualizer as hn_visualizer
from pm4py.objects.log.util import log as utils
from pm4py.statistics.start_activities.log.get import get_start_activities
from pm4py.statistics.end_activities.log.get import get_end_activities
from pm4py.algo.filtering.log.end_activities import end_activities_filter
from pm4py.algo.discovery.alpha import algorithm as alpha_miner
from pm4py.visualization.petri_net import visualizer as pn_visualizer
from pm4py.algo.discovery.inductive import algorithm as inductive_miner
from pm4py.algo.evaluation import evaluator as evaluation
from pm4py.algo.conformance.tokenreplay import algorithm as token_replay

output = open("output.txt", "w")	
sys.stdout = output

# 1. Διαβάζει το event log
log = read_xes('activitylog_uci_detailed_labour.xes')

print(log)

event_stream = stream_converter.apply(log, variant=stream_converter.Variants.TO_EVENT_STREAM)

#2 Δομή του trace
print('Trace structure: ', list(log[0].attributes.keys()))
#2 Δομή του event
print('Event structure: ',list(log[0][0].keys()))
#3 Πλήθος traces
print("Number of traces: ", len(log))
#4 Πλήθος events
print("Number of events: ", len(event_stream))

#5 Διαφορετικά events
events = utils.get_event_labels(log,'concept:name')
print('Unique Events')
print(events)

#6 Εμφανίζει τις δραστηριότητες με τις οποίες αρχίζουν και τελειώνουν τα traces
#Start activities
start_act = get_start_activities(log)
print('Start activities: ', start_act)
#End activities
end_act = get_end_activities(log)
print('End activities', end_act)

#6 Συχνότητα εμφάνισής events
heu_net = heuristics_miner.apply_heu(log)
gviz = hn_visualizer.apply(heu_net)
hn_visualizer.save(gviz, "heu_net.png")

#7 Εμφάνιση πίνακα
dataframe = convert_to_dataframe(log) 
print(dataframe.to_string())

#8 Tελειώνουν με την δραστηριότητα "End"
filtered_log = end_activities_filter.apply(log, ['End'])

#9 + 10
#Process Discovery with alpha miner
net, initial_marking, final_marking = alpha_miner.apply(log)
#show petri net
gviz= pn_visualizer.apply(net, initial_marking, final_marking)
pn_visualizer.save(gviz, "alpha_net_miner_log.png")
# Evaluation
evaluation_result = evaluation.apply(log, net, initial_marking, final_marking)
print("Alpha Miner PetriNet - Log - Evaluation")
print(evaluation_result)
#Replay Fitness
replayed_traces = token_replay.apply(log, net, initial_marking, final_marking)
print("Alpha Miner PetriNet - Log - Conformace check - Replay Fitness")
for trace in replayed_traces:
    print(trace)

net, initial_marking, final_marking = alpha_miner.apply(filtered_log)
#show petri net
gviz= pn_visualizer.apply(net, initial_marking, final_marking)
pn_visualizer.save(gviz, "alpha_net_miner_filtered.png")
# Evaluation
evaluation_result = evaluation.apply(filtered_log, net, initial_marking, final_marking)
print('Alpha Miner PetriNet - Filtered - Evaluation\n')
print(evaluation_result)
#Replay Fitness
replayed_traces = token_replay.apply(filtered_log, net, initial_marking, final_marking)
print('Alpha Miner PetriNet - Filtered Log - Conformance check - Replay Fitness\n')
for trace in replayed_traces:
    print(trace)

#Process Discovery with heuristics miner
#Log
net, initial_marking, final_marking = heuristics_miner.apply(log)
gviz= pn_visualizer.apply(net, initial_marking, final_marking)
pn_visualizer.save(gviz, "heuristics_miner_log.png")
# Evaluation
evaluation_result = evaluation.apply(log, net, initial_marking, final_marking)
print('Heuristics Miner PetriNet - Log - Evaluation\n')
print(evaluation_result)
#Replay Fitness
replayed_traces = token_replay.apply(log, net, initial_marking, final_marking)
print('Heuristics Miner PetriNet - Log - Conformance check - Replay Fitness\n')
for trace in replayed_traces:
    print(trace)

#Filtered Log
net, initial_marking, final_marking = heuristics_miner.apply(filtered_log)
gviz= pn_visualizer.apply(net, initial_marking, final_marking)
pn_visualizer.save(gviz, "heuristics_miner_filtered.png")
# Evaluation
evaluation_result = evaluation.apply(filtered_log, net, initial_marking, final_marking)
print('Heuristics Miner PetriNet - Filtered - Evaluation\n')
print(evaluation_result)
#Replay Fitness
replayed_traces = token_replay.apply(filtered_log, net, initial_marking, final_marking)
print('Heuristics Miner PetriNet - Filtered Log - Conformance check - Replay Fitness\n')
for trace in replayed_traces:
    print(trace)

#Process Discovery with Inductive miner
#Log
net, initial_marking, final_marking = inductive_miner.apply(log)
gviz= pn_visualizer.apply(net, initial_marking, final_marking)
pn_visualizer.save(gviz, "inductive_miner_log.png")
# Evaluation
evaluation_result = evaluation.apply(log, net, initial_marking, final_marking)
print('Inductive Miner PetriNet - Log - Evaluation\n')
print(evaluation_result)
#Replay Fitness
replayed_traces = token_replay.apply(log, net, initial_marking, final_marking)
print('Inductive Miner PetriNet - Log - Conformace check - Replay Fitness\n')
for trace in replayed_traces:
    print(trace)

#Filtered Log
net, initial_marking, final_marking = inductive_miner.apply(filtered_log)
gviz= pn_visualizer.apply(net, initial_marking, final_marking)
pn_visualizer.save(gviz, "inductive_miner_filtered.png")
# Evaluation
evaluation_result = evaluation.apply(filtered_log, net, initial_marking, final_marking)
print('Inductive Miner PetriNet - Filtered - Evaluation\n')
print(evaluation_result)
#Replay Fitness
replayed_traces = token_replay.apply(filtered_log, net, initial_marking, final_marking)
print('Inductive Miner PetriNet - Filtered - Conformace check - Replay Fitness\n')
for trace in replayed_traces:
    print(trace)

output.close()