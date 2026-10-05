
proc import_model { model_path F } { return "$model_path/dpi.cpp -cpp g++ -CFLAGS \"-I$model_path/include -DMODEL_F=$F\"" }
