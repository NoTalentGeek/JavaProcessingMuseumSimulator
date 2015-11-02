/*Creating a Panel class for each object museum.*/
class Panel                                         {

    PFont   layoutPanelPFont;           /*Font variable to hold the font style.*/
    color   fillColor;                  /*The color of the panel.*/
    int     layoutTextSizeInt   = 72;   /*The default font size for the panel.*/

    Panel(){}

    void DrawVoid(

        color   _fillColor      ,
        int     _widthPanelInt  ,
        int     _heightPanelInt ,
        int     _xPanelInt      ,
        int     _yPanelInt      ,
        String  _textString

    ){

    	/*Fill color for the panel.*/
        fill                    (_fillColor);
        rect                    (_xPanelInt, _yPanelInt, _widthPanelInt, _heightPanelInt, 10);
        noFill                  ();

        /*Fill white color for the text.*/
        fill                    (255);
        textAlign               (CENTER);
        String textTextString   = _textString;
        layoutPanelPFont        = createFont("Georgia", layoutTextSizeInt);
        textFont                (layoutPanelPFont);

        /*Iterate font size so that it went a bit smaller than the panel.*/
        while(

            (textWidth(_textString)	> (_widthPanelInt  - layoutOffsetInt))  ||
            (layoutTextSizeInt		> (_heightPanelInt - layoutOffsetInt))

        ){

            layoutTextSizeInt           --;
            if(layoutTextSizeInt  <= 1) { layoutTextSizeInt = 1; }
            layoutPanelPFont            = createFont("Georgia", layoutTextSizeInt);
            textFont                    (layoutPanelPFont);

        }

        /*Set the text position.*/
        int xTextInt            = _xPanelInt + ( _widthPanelInt/2);
        int yTextInt            = _yPanelInt + (_heightPanelInt/2) + ((layoutTextSizeInt*11)/45);
        /*Display the text.*/
        text                    (textTextString, xTextInt, yTextInt);
        noFill                  ();

    }


}