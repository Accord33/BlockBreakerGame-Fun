class GameObject {
    float x, y, z, _width, _height, _depth;
    GameObject (float x, float y, float z, float _width, float _height, float _depth) {
        this.x = x;
        this.y = y;
        this.z = z;
        this._width = _width;
        this._height = _height;
        this._depth = _depth;
    }
    void update() {
        pushMatrix();
        translate(this.x, this.y, this.z);
        box(this._width, this._height, this._depth);
        popMatrix();
    }
}