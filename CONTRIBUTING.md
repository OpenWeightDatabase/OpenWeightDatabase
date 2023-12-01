# Contributing to OWD

## Before contributing... Some rules!

Here are some basic rules to follow in order to contribute to the project properly:

* We are interested in **outdoor gear and equipment!**. This includes climbing, hiking, skiing, etc. Do not hesitate to create a new category if your item does not fit one already present.
* Only share items **you weighted yourself!** By doing so, we can ensure that the weight is accurate.
* For electronic devices, weight them **without batteries** when possible.
* An item will be updated if the measured weight difference is **bigger than 5 grams**.

## How to contribute

### I have a GitHub account

Great, it will be easy for you! You have two ways to propose new items, depending on your skills:

* **East way**: use one of the two forms available in the [issues creation menu](https://github.com/OpenWeightDatabase/OpenWeightDatabase/issues/new/choose). Your issue will be handled by someone to create a PR.

* **More complex way**: Open a PR with your contribution. Weights are saved in the `db/` folder under the CSV format. Then, they are rendered into Markdown files that can be handled by `mdbook` easily, using the `render.sh` script.
  * We use `mdbook` to automatically generate the HTML pages from the Markdown content. Add your item(s) to the appropriate CSV file under `db/`, and then run `bash render.sh` and `make build` to build the HTML pages. 

### I do not have a GitHub account

If you do not have a GitHub account, you can send me an email to `owd@plop.name` with the following informations:

**To add a new item:**
* Category (sleeping bags, climbing shoes...)
* Brand
* Model
* Weight (in grams)
* Size (if wearable)

**To report an inacurate item:**
* Name of the item
* Link to the item on the website
* What's wrong with the item
* Do you know how to solve this? (the correct weight for example)

## Thanks again! :heart:
