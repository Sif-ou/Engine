#pragma once
#include "../../struct.hpp"
#include <filesystem>
#include <fstream>
#include "../../external/nlohmann/json.hpp"


using json = nlohmann::json ;

enum class Action 
{
    test ,
    COUNT 
} ;




class KeyLoader
{

private:
    

   std::array < SDL_Scancode , KEYS_NUM > m_Keys ;


public:

    KeyLoader() ;
    ~KeyLoader() = default ;


    std::array < SDL_Scancode , KEYS_NUM >& getKeys()  ;

    
};


