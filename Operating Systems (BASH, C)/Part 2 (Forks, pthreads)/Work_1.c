#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
int main() { //MAIN p0 process
    int p1,p2,p3,p4,p5,p6,fd[2],n;
    char message[25];
    if((p2=fork())==0){ //p2 process
        if     ((p4=fork())==0){printf("p4 PID=%d PPID=%d\n",getpid(),getppid()); exit(0);}
        else if((p5=fork())==0){printf("p5 PID=%d PPID=%d\n",getpid(),getppid()); exit(0);}
        else if((p6=fork())==0){printf("p6 PID=%d PPID=%d\n",getpid(),getppid()); exit(0);}
        else                   {wait(0); wait(0); wait(0); //p2 waiting p4,p5,p6
                                printf("p2 PID=%d PPID=%d\n",getpid(),getppid()); exit(0);}
    }
    else{   //p0 continuing
        wait(0); //p0 process waiting p2
        printf("p0 PID=%d PPID=%d\n",getpid(),getppid());
        if((p1=fork())==0){ //p1 process
            printf("p1 PID=%d PPID=%d\n",getpid(),getppid());
            pipe(fd);
            if((p3=fork())==0){ //p3 process
                printf("p3 PID=%d PPID=%d\n",getpid(),getppid());
                close(fd[0]);
                write(fd[1],"hello from your child\n",23);
                close(fd[1]);
                exit(0); //p3 exit
            }
            else{wait(0); //p1 waiting p3
                close(fd[1]);
                n=read(fd[0],message,sizeof(message));
                write(1, message, n);
                close(fd[0]);
                exit(0); //p1 exit
            }
        }
        else{ //p0 continuing
            wait(0);
            printf("The Source Code:\n");
            execlp("cat","-n",__FILE__,NULL);
        }
    }
}
