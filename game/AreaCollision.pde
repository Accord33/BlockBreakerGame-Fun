// 壁の当たり判定
class AreaCollision {
    float x, y, z, _width, _height, _depth;
    AreaCollision(float x, float y, float z, float _width, float _height, float _depth) {
        this.x = x;
        this.y = y;
        this.z = z;
        this._width = _width;
        this._height = _height;
        this._depth = _depth;
    }

    void update() {
        // stroke(255,0,0);
        // fill(255,0,0);
        // pushMatrix();
        // translate(this.x+_width/2, this.y-_height/2, this.z+_depth/2);
        // box(this._width, this._height, this._depth);
        // popMatrix();
    }

    // 壁の当たり判定の中にいるかどうか
    boolean hit(float tx, float ty, float tz) {
        if (this.x <= tx && tx <= this.x+_width) {
            if (this.z <= tz && tz <= this.z+_depth) {
                if (this.y-this._height <= ty && ty <= this.y) {
                    return true;
                }
            }
        }
        return false;
    }
}
