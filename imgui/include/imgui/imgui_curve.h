#ifndef IMGUI_CURVE_H
#define IMGUI_CURVE_H

#include "imgui.h"
#include <float.h>
#ifndef IMGUI_DISABLE
namespace ImGui
{
static const float CurveTerminator = -10000;
int Curve(const char* label, const ImVec2& size, const int maxpoints, ImVec2* points, int* selection, const ImVec2& rangeMin = ImVec2(0, 0), const ImVec2& rangeMax = ImVec2(1, 1), float highlight_x = FLT_MAX);
float CurveValue(float p, int maxpoints, const ImVec2* points);
float CurveValueSmooth(float p, int maxpoints, const ImVec2* points);
}; // namespace ImGui
#endif // IMGUI_DISABLE

#endif // IMGUI_CURVE_H