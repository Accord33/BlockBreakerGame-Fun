class GameObject {
    float x, y, z, _width, _height, _depth;
    GameObject (float _width, float _height, float _depth, float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
        this._width = _width;
        this._height = _height;
        this._depth = _depth;
    }
    void update() {
        pushMatrix();
        translate(x, y, z);
        box(this._width, this._height, this._depth);
        popMatrix();
    }
}