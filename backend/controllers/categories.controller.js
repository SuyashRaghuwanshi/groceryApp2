const categoriesService = require("../services/categories.services.js");
const upload = require("../middleware/category.upload.js");



exports.create = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const path = req.file?.path ? req.file.path.replace(/\\/g, "/") : "";

            var model = {
                categoryName: req.body.categoryName,
                categoryDescription: req.body.categoryDescription,
                categoryImage: path !="" ? "/" + path : "",
            };

            categoriesService.createCategory(model, (error, results) => {
                if (error) {
                    return next(error);
                } else {
                    return res.status(200).json({
                        message: "Success",
                        data: results,
                    });
                }
            });
        }
    });
};

exports.findAll = (req, res, next) => {
    var model = {
        categoryName: req.query.categoryName,
        pageSize: req.query.pageSize,
        page: req.query.page,
    };

    categoriesService.getCategories(model, (error, results) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).send({
                message: "Success",
                data: results,
            });
        }
    });
}

exports.findOne = (req, res, next) => {
    var model = {
        categoryId: req.params.id,
    };
    categoriesService.getCategoryById(model, (error, results) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).json({
                message: "Success",
                data: results,
            });
        }
    });
};

exports.update = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const path = req.file !=undefined? req.file.path.replace(/\\/g,"/"):"";

            var model = {
                categoryId: req.params.id,
                categoryName: req.body.categoryName,
                categoryDescription: req.body.categoryDescription,
                categoryImage: path != "" ? "/" + path : "",
            };
            categoriesService.updateCategory(
                model, (error, results) => {
                    if (error) {
                        return next(error);
                    } else {
                        return res.status(200).send({
                            message: "Success",
                            data: results,
                        });
                    }
                }
            )
        }
    });
};

exports.delete = (req, res, next) => {
    var model = {
        categoryId: req.params.id,
    };
    categoriesService.deleteCategory(model, (error, results) => {
        if (error) {
            return next(error);
        } else {
            return res.status(200).json({
                message: "Success",
                data: results,
            });
        }
    });
};