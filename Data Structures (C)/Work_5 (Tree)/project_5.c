#include<stdio.h>
#include<stdlib.h>
#include<assert.h>

struct personT{
	char name[21];
	char phone[15];
};

struct treenode{
	struct personT data;
	struct treenode *left;
	struct treenode *right;
};
typedef struct treenode *PTR;

int display_menu();
void insert_node(PTR *pt, struct personT x);
int count(PTR t);
int height(PTR t);
void preorder_traversal(PTR t);
void inorder_traversal(PTR t);
void postorder_traversal(PTR t);
void find_node(PTR t, char *n, int i);


int main(){
	FILE *fp;
	struct personT p;
	char onoma[21];
	int in , i=0;
	PTR bt;
	
	bt=NULL;
	fp=fopen("person.dat","rb"); assert(fp!=NULL);
	fread(&p,sizeof(struct personT),1,fp);
	while(!feof(fp)){
		insert_node(&bt,p);
		fread(&p,sizeof(struct personT),1,fp);
	}
	fclose(fp);
	
	printf("Tree's features.\n");
	printf("\tNumber of nodes in tree : %d\n",count(bt));
	printf("\tHeight of tree : %d\n",height(bt));
	
	while(in = display_menu()){
		if(in == 1){
			printf("Preorder traversal\n");
			preorder_traversal(bt);
		}
		else if(in == 2){
			printf("Inorder traversal\n");
			inorder_traversal(bt);
		}
		else if(in == 3){
			printf("Postorder traversal\n");
			postorder_traversal(bt);
		}
		else if(in == 4){
			printf("Tree search\nGive name : ");
			scanf("%s",onoma);
			find_node(bt, onoma, i);
		}
	}
	
	return 0;
}

int display_menu(){
	int x;
	printf("\nMENU\n");
	printf("=============\n");
	printf("1. Preorder traversal\n");
	printf("2. Inorder traversal\n");
	printf("3. Postorder traversal\n");
	printf("4. Tree search\n");
	printf("0. Exit\n");
	while(scanf("%d",&x)){
		if(0<=x && x<=4)
			return x;
		else
			printf("ERROR. Choice does not exist.\n");
	}
}

void insert_node(PTR *pt, struct personT x){
	PTR t;
	t= *pt;
	if(t==NULL){
		t=(struct treenode *)malloc(sizeof(struct treenode));
		assert(t!=NULL);
		t->data=x;
		t->left=NULL;
		t->right=NULL;
	}
	else if(strcmp(x.name,t->data.name)<0)
		insert_node(&(t->left),x);
	else
		insert_node(&(t->right),x);
	*pt = t;
}

int count(PTR t){
	if(t==NULL) return(0);
	return(count(t->left) + count(t->right) + 1);
}

int height(PTR t){
	int u,v;
	if(t==NULL) return(-1);
	u = height(t->left);
	v=height(t->right);
	if (u>v) return(u+1);
	else return(v+1);
}

void preorder_traversal(PTR t){
	if(t!=NULL){
		printf("\tnode address=%d\n",t);
		printf("\t%s\n",t->data.name);
		printf("\t%s\n",t->data.phone);
		printf("\tleft=%d\n",t->left);
		printf("\tright=%d\n",t->right);
		printf("\n");
		preorder_traversal(t->left);
		preorder_traversal(t->right);
	}
}

void inorder_traversal(PTR t){
	if(t!=NULL){
		inorder_traversal(t->left);
		printf("\tnode address=%d\n",t);
		printf("\t%s\n",t->data.name);
		printf("\t%s\n",t->data.phone);
		printf("\tleft=%d\n",t->left);
		printf("\tright=%d\n",t->right);
		printf("\n");
		inorder_traversal(t->right);		
	}
}

void postorder_traversal(PTR t){
	if(t!=NULL){
		postorder_traversal(t->left);
		postorder_traversal(t->right);
		printf("\tnode address=%d\n",t);
		printf("\t%s\n",t->data.name);
		printf("\t%s\n",t->data.phone);
		printf("\tleft=%d\n",t->left);
		printf("\tright=%d\n",t->right);
		printf("\n");		
	}	
}

void find_node(PTR t, char *n, int i){
	i++;
	if(t==NULL){
		printf("\nThe node was not found.\n");
		printf("Number of searches: %d\n",i);
	}
	else if(strcmp(t->data.name,n)==0){
		printf("\nThe node was found!!!\n");
		printf("Number of searches: %d\n",i);
		printf("\t%s\n",t->data.name);
		printf("\t%s\n",t->data.phone);
		printf("\n");
	}
	else if(strcmp(n,t->data.name)<0)
		find_node(t->left,n,i);
	else
		find_node(t->right,n,i);
}








