import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType

from autogen.settings import setup_qt_environment
from models.computer_list_model import ComputerListModel

# Import here the Python files that define QML elements


def main():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    # Register QML types
    qmlRegisterType(ComputerListModel, "CyberMaster", 1, 0, "ComputerListModel")
    
    # Create computer model and set as context property
    computer_model = ComputerListModel()
    engine.rootContext().setContextProperty("computerModel", computer_model)
    
    print(f"Computer model created with {computer_model.rowCount()} computers")

    setup_qt_environment(engine)

    if not engine.rootObjects():
        sys.exit(-1)

    ex = app.exec()
    del engine
    return ex


if __name__ == "__main__":
    sys.exit(main())
