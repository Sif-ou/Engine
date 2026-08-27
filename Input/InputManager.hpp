#pragma once
#include "KeyLoader/KeyLoader.hpp"
#include <unordered_map>
#include <string>
#include <functional>
#include <array>


class InputManager 
{


private:

   
    const Uint8* m_keyboardState = nullptr ;
    std::array< SDL_Scancode , static_cast<size_t>(Action::COUNT) > m_Actions ;
    std::unique_ptr<KeyLoader> keyloader  ;


    bool m_quitRequested = false;
    int m_mouseX = 0;
    int m_mouseY = 0;

public:

    InputManager() ;
    void Update() ;
    bool hasQuitRequested() const  ;


    
    inline bool isActionDown(Action action) const ;
    void bindAction(Action action, SDL_Scancode scancode) ;



    int getMouseX() const ; 
    int getMouseY() const ;


};

