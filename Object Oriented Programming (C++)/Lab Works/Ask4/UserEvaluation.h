#ifndef UserEvaluation_h
#define UserEvaluation_h

#include <string>

class UserEvaluation
{
private:
    int stars;
    std::string username;
    std::string comments;
public:

    UserEvaluation(unsigned int starsF=0, std::string usernameF="-", std::string commentsF="-")
    {
        setStars(starsF);
        setUsername(usernameF);
        setComments(commentsF);
    }

    UserEvaluation(const UserEvaluation &eval)
    {
        setStars(eval.stars);
        setUsername(eval.username);
        setComments(eval.comments);
    }

    UserEvaluation& operator= (const UserEvaluation &eval)
    {
        setStars(eval.stars);
        setUsername(eval.username);
        setComments(eval.comments);
        return *this;
    }


    unsigned int getStars(){return stars;}
    std::string getUsername(){return username;}
    std::string getComments(){return comments;}

    void setStars(int starsF){
        try{
            if((starsF < 0) || (5 < starsF))
                throw -1;
            stars = starsF;
        } catch(int e){
            stars = 0;
            std::cout << "ERROR: Stars must be from 0 to 5." << std::endl;
        }
    }
    void setUsername(std::string usernameF){username = usernameF;}
    void setComments(std::string commentsF){comments = commentsF;}

    void printData()
    {
        std::cout << "Username: " << username << "\tStars: " << stars << std::endl;
        std::cout << "Comments: " << comments << std::endl;
    }
};

#endif