from ekklesia_portal.helper.cell import Cell
from ekklesia_portal.database.datamodel import Argument


class ArgumentCell(Cell):
    model = Argument
    model_properties = ['id', 'title', 'abstract', 'details', 'created_at', 'author']

    def footer(self):
        return self.render_template('argument_footer.j2.jade')

    @property
    def header_link(self):
        if 'header_link' in self.options:
            return self.options['header_link']

        return self.self_link


