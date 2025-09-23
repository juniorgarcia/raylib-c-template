#include "game.h"

#include <raylib.h>
#include <raymath.h>

int main(void)
{
  InitWindow(SCR_WIDTH, SCR_HEIGHT, "raylib game");
  SetTargetFPS(60);
  const char *text     = "Hello, raylib!";
  const float fontSize = 25.0f;
  int         textSize = MeasureText(text, fontSize);

  while (!WindowShouldClose())
    {
      // MARK: update logic

      // MARK: drawing
      BeginDrawing();

      ClearBackground(RAYWHITE);
      DrawText(
          text, (SCR_WIDTH / 2) - textSize / 2, SCR_HEIGHT / 2, fontSize, BLUE
      );
      EndDrawing();
    }

  CloseWindow();
  return 0;
}
