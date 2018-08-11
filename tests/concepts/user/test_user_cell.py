from unittest.mock import Mock
from pytest import fixture
from ekklesia_portal.concepts.user.user_cells import UserCell


@fixture
def user_cell(user_with_departments_factory):
    # XXX: pytest_factoryboy bug?: using the fixture user_with_departments results in an error complaining about a missing 'list' fixture
    return UserCell(user_with_departments_factory(), Mock())


def test_user_cell(user_cell):
    assert user_cell.argument_count == 0
    assert user_cell.supported_proposition_count == 0
    assert len(user_cell.departments_with_subject_areas) == 2
    subject_areas = set(area for _, areas in user_cell.departments_with_subject_areas for area in areas)
    assert len(subject_areas) == 4
