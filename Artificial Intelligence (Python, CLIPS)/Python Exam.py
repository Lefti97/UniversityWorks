import copy

# Κωδικοποίηση του τελεστή με ενσωματωμένα τα απαραίτητα σχόλια.
def kitchen_renovation(state):
    new_state = state

    # Ελέγχουμε αν το παλαιό χρώμα της κουζίνας είναι ίδιο με το νέο
    if new_state[0][1] != new_state[3][1]:
        # Ελέγχουμε αν υπάρχουν έπιπλα στην κουζίνα
        if new_state[3][0] != 0:
            # Βγάζουμε τα έπιπλα
            new_state[0][0] = new_state[0][0] - new_state[3][0]
            new_state[3][0] = 0
        # Βάφουμε την κουζίνα
        new_state[3][1] = new_state[0][1]
    # Επιστρέφουμε την νέα κατάσταση του διαμερίσματος
    return new_state

# Δημιουργία των υπόλοιπων τελεστών που επιστρέφουν απλώς None 
def trapezaria_renovation(state):
    return None

def upnodwm_renovation(state):
    return None

def mpaniou_renovation(state):
    return None

# Δημιουργία κατάλληλης findchildren 

'''
Συνάρτηση εύρεσης απογόνων της τρέχουσας κατάστασης 
'''
def find_children(state):
    children = []
    enter_state = copy.deepcopy(state)
    child = kitchen_renovation(enter_state)

    if child is not None:
        children.append(child)

    return children


# Κώδικας αναζήτησης με παρακολούθηση μετώπου

def expand_front(front):
    if front:
        node = front.pop(0)
        children = find_children(node)
        for i in range(len(children)):
            front.insert(0, children[i])
    return front



def is_goal_state(state):
    for i in state[1:5]: 
        if state[0][1] != i[1]:
            return False
    return True


def find_solution(front, closed):
    if not front:
        print('_NO_SOLUTION_FOUND_')
    elif front[0] in closed:
        new_front = copy.deepcopy(front)
        new_front.pop(0)
        find_solution(new_front, closed)
    elif is_goal_state(front[0]):
        print('_GOAL_FOUND_')
        print(front[0])
    else:
        closed.append(front[0])
        front_copy = copy.deepcopy(front)
        front_children = expand_front(front_copy)
        closed_copy = copy.deepcopy(closed)
        find_solution(front_children, closed_copy)

def make_front(state):
    return [state]

def main():
    init_state = [[5, 'W'], [0, 'W'], [0, 'W'], [5, 'K'], [0, 'W']]

    print('____BEGIN__SEARCHING____')
    find_solution(make_front(init_state), [])

if __name__ == "__main__":
    main()