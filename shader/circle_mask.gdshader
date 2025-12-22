// canvas_item 用于 2D 节点，可在 Godot 的 2D 渲染管线中使用
shader_type canvas_item;

// 定义外部可控参数
uniform float progress : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    // 计算到中心点的距离
    float dist = distance(vec2(0.5), UV);
	// float step(float edge, float x)
	// 阶跃函数（step function），根据阈值返回 0 或 1;
	// 如果 x < edge：返回 0.0
	// 如果 x >= edge：返回 1.0
	COLOR.a = step(progress, dist);
}