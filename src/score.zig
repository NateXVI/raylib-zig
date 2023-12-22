const std = @import("std");
const game_util = @import("game.zig");
const raylib = @import("raylib");

pub fn updateScore(game: *game_util.Game) void {
    for (&game.pipes.pipes) |*pipe| {
        if (!pipe.captured and pipe.x < game.bird.pos.x + @divFloor(game.bird.size.x, 2)) {
            pipe.captured = true;
            game.score += 1;
        }
    }
}

pub fn drawScore(game: *game_util.Game) void {
    const score = raylib.TextFormat(std.heap.page_allocator, "{}", .{game.score}) catch {
        return;
    };
    raylib.DrawText(
        score,
        10,
        10,
        20,
        raylib.WHITE,
    );
}
