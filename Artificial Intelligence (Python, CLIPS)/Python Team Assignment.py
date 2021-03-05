# This assignment was made by a team of two 

""" ----------------------------------------------------------------------------
******** Search Code for DFS  and other search methods
******** (expanding front only)
******** author:  AI lab
********
******** Κώδικας για α DFS και άλλες μεθόδους αναζήτησης
******** (επέκταση μετώπου μόνο)
******** Συγγραφέας: Εργαστήριο ΤΝ
"""
import copy
import sys

sys.setrecursionlimit(10 ** 6)

# Λίστα γειτνίασης
spaces = {
    1: [2, 4],
    2: [1, 3],
    3: [2, 4, 6],
    4: [1, 3, 5],
    5: [4, 6],
    6: [3, 5]
}

iteration = 0


# ---------------------------------------------
# Τελεστής IN:
# Εισάγει ένα αυτοκίνητο στο χώρο
# ---------------------------------------------
def enter(state):
    # υπάρχει πλατφόρμα στο χώρο εισόδου χωρίς αυτοκίνητο (NO)
    if state[0] != 0 and state[1][0][0] == 'P' and state[1][1] == 'NO':
        # είσοδος αυτοκινήτου στο parking
        new_state = [state[0] - 1] + [[state[1][0], 'YES']] + state[2:]
        return new_state


# ---------------------------------------------
# Αντιμεταθέτει μέσα σε μια λιστα state τα δυο στoιχεία
# της που βρίσκονται στις θέσεις i & j
# ---------------------------------------------
def swap(state_l, i, j):
    state_l[i], state_l[j] = state_l[j], state_l[i]
    return state_l


# ---------------------------------------------
# Μετακίνηση 1ης πλατφόρμας που συνορεύει με κενό
# χώρο προς το γειτονικό της κενό χώρο
# ---------------------------------------------
def neighbour1(state):
    elem = ['E', 'NO']
    i = state.index(elem) if elem in state else -1
    if i >= 0:
        swap(state, i, spaces[i][0])
        return state


# ---------------------------------------------
# Μετακίνηση 1ης πλατφόρμας που συνορεύει με κενό
# χώρο προς το γειτονικό της κενό χώρο
# ---------------------------------------------
def neighbour2(state):
    elem = ['E', 'NO']
    i = state.index(elem) if elem in state else -1
    if i >= 0:
        swap(state, i, spaces[i][1])
        return state


# ---------------------------------------------
# Μετακίνηση 1ης πλατφόρμας που συνορεύει με κενό
# χώρο προς το γειτονικό της κενό χώρο
# ---------------------------------------------
def neighbour3(state):
    elem = ['E', 'NO']
    i = state.index(elem) if elem in state else -1
    if i >= 0:
        if len(spaces[i]) < 3:
            return None
        swap(state, i, spaces[i][2])
        return state


# ---------------------------------------------
# Συνάρτηση εύρεσης απογόνων της τρέχουσας κατάστασης
# ---------------------------------------------
def find_children(state):
    children = []
    enter_state = copy.deepcopy(state)
    enter_child = enter(enter_state)

    tr1_state = copy.deepcopy(state)
    tr1_child = neighbour1(tr1_state)
    tr2_state = copy.deepcopy(state)
    tr2_child = neighbour2(tr2_state)
    tr3_state = copy.deepcopy(state)
    tr3_child = neighbour3(tr3_state)

    if tr1_child is not None:
        children.append(tr1_child)
    if tr2_child is not None:
        children.append(tr2_child)
    if tr3_child is not None:
        children.append(tr3_child)
    if enter_child is not None:
        children.append(enter_child)
    return children


# ---------------------------------------------
# Αρχικοποίηση Μετώπου
# ---------------------------------------------
def make_front(state):
    return [state]


# ---------------------------------------------
# Αρχικοποίηση Ουράς
# ---------------------------------------------
def make_queue(state):
    return [[state]]


# ---------------------------------------------
# Ευριστικό κριτήριο, επιστρέφει τον αριθμό
# αυτοκινήτων της τρέχουσας κατάστασης
# ---------------------------------------------
def heuristic_front(e):
    return e[0]


def heuristic_queue(path):
    return path[-1][0]


# ---------------------------------------------
# Επέκταση ουρας
# ---------------------------------------------
def extend_queue(queue, method):
    if method == 'DFS':
        node = queue.pop(0)
        queue_copy = copy.deepcopy(queue)
        children = find_children(node[-1])
        for child in children:
            path = copy.deepcopy(node)
            path.append(child)
            queue_copy.insert(0, path)
    elif method=='BFS':
        node = queue.pop(0)
        queue_copy = copy.deepcopy(queue)
        children = find_children(node[-1])
        for child in children:
            path = copy.deepcopy(node)
            path.append(child)
            queue_copy.append(path)
    elif method=='BestFS':
        node = queue.pop(0)
        queue_copy = copy.deepcopy(queue)
        children = find_children(node[-1])
        for child in children:
            path = copy.deepcopy(node)
            path.append(child)
            queue_copy.append(path)
        queue_copy.sort(key=heuristic_queue)

    return queue_copy


# ---------------------------------------------
# Επέκταση μετώπου
# ---------------------------------------------
def expand_front(front, method):
    if method == 'DFS':
        if front:
            node = front.pop(0)
            children = find_children(node)
            for i in range(len(children)):
                front.insert(0, children[i])
    elif method == 'BFS':
        if front:
            node = front.pop(0)
            children = find_children(node)
            for i in range(len(children)):
                front.append(children[i])
    elif method == 'BestFS':
        if front:
            node = front.pop(0)
            children = find_children(node)
            for i in range(len(children)):
                front.append(children[i])
            front.sort(key=heuristic_front)
    return front


# ---------------------------------------------
# Συναρτήσεις για την υλοποίηση του προβλήματος
# ---------------------------------------------
def is_goal_state(state):
    return state[0] == 0


# ---------------------------------------------
# Βασική αναδρομική συνάρτηση για δημιουργία δέντρου αναζήτησης
# (αναδρομική επέκταση δέντρου)
# ---------------------------------------------
def find_solution(front, queue, closed, method):
    if not front:
        print('_NO_SOLUTION_FOUND_')
    elif front[0] in closed:
        new_front = copy.deepcopy(front)
        new_front.pop(0)
        new_queue = copy.deepcopy(queue)
        new_queue.pop(0)
        find_solution(new_front, new_queue, closed, method)
    elif is_goal_state(front[0]):
        print('_GOAL_FOUND_')
        print(front[0])
        print("Queue:")
        for node in queue[0]:
            print(node)
    else:
        closed.append(front[0])
        front_copy = copy.deepcopy(front)
        front_children = expand_front(front_copy, method)
        queue_copy = copy.deepcopy(queue)
        queue_children = extend_queue(queue_copy, method)
        closed_copy = copy.deepcopy(closed)
        find_solution(front_children, queue_children, closed_copy, method)


def main():
    # initial_state = [3, ['E', 'NO'], ['P1', 'NO'], ['P2', 'NO'], ['P3', 'NO']]
    initial_state = [5, ['E', 'NO'], ['P1', 'NO'], ['P2', 'NO'], ['P3', 'NO'], ['P4', 'NO'], ['P5', 'NO']]

    method = "DFS"

    print('____BEGIN__SEARCHING____')
    find_solution(make_front(initial_state), make_queue(initial_state), [], method)


if __name__ == "__main__":
    main()